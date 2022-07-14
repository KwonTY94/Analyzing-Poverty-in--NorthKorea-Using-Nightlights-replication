#Firure 1. Average annual growth rate map of North Korea

# libraries and datasets
library(ggplot2) # Data visualization
library(raster) # handling spatial data frames
library(magrittr) # additional pipe operators
library(RColorBrewer) # more distinct color palettes
library(sp) # mangling with polygons
library(spdep) # neighbor matrix & spatial models
library(gridExtra) # parallel plotting
library(GGally) # correlation plots
library(rgeos) # allocation of points to polygons
library(caret) # sophisticated preprocessing
library(tidyverse) # holds several packages for data mangling

# get all yearly files of night lights (10 years)
(nl_file_names <- list.files('C:/Users/user/Desktop/data_analysis/dprk_satellite_analysis_20220713', 
                             pattern='.tif$',
                             recursive=T,
                             full.names=T))
# stack night light data on top of each other to make one dataset
nl <- stack(nl_file_names)

# simplifying variable names
names(nl) <- 
  str_sub(names(nl), start=1, end=7) %>% # Only extract up until the year 
  sub("^...", "light_value_", x=.) # substitute with more meaningful name

# read shapefiles of the North Korea
prk_adm0 <- readRDS("C:/Users/user/Desktop/data_analysis/dprk_satellite_analysis_20220713/PRK_adm_shp/PRK_adm0.rds")
prk_adm1 <- readRDS("C:/Users/user/Desktop/data_analysis/dprk_satellite_analysis_20220713/PRK_adm_shp/PRK_adm1.rds")
prk_adm2 <- readRDS("C:/Users/user/Desktop/data_analysis/dprk_satellite_analysis_20220713/PRK_adm_shp/PRK_adm2.rds")

# Plotting options
# empty theme for plots
map_theme <- theme_bw() +
  theme(
    plot.background = element_blank()
    ,panel.grid.major = element_blank()
    ,panel.grid.minor = element_blank()
    ,panel.border = element_blank()
    ,axis.text = element_blank()
    ,axis.title = element_blank()
    ,axis.ticks = element_blank()
  )

# three sequential color scheme
BuYlRd.11.p <- colorRampPalette(brewer.pal(11, "RdYlBu"))

# Exploratory View of North Korean map shape
par(mfrow=c(1,3))
plot(prk_adm0, main='Regions (adm0)')
plot(prk_adm1, main='Provinces (adm1)')
plot(prk_adm2, main='Cities & Municipalities (adm2)', lwd=0.6)


#Exploratory View: Night light data
# I will use a Cities & Municipalities-level data to describe socioeconomic development of North Korea in a subregional level.
# Regional SpatialPolygonsDataFrame to normal data.frame for collection of variables.
prk_adm2_df <- 
  prk_adm2 %>% 
  fortify() %>% 
  mutate(id=as.integer(id))

# crop night lights to North Korea
nl_prk <- crop(nl, extent(prk_adm2))
rm(nl) 

# Figure 1: plot the night lights of North Korea over a 10 years span
plot(nl_prk)

# transform light data into raster dataset for uniting datasets
nl_prk_2 <- nl_prk
prk_raster_2 <- rasterize(prk_adm2,
                          nl_prk,
                          dataType='INT1U')

# control for NAs
nl_prk_2[is.na(prk_raster_2)] <- NA


# extract values per pixel into a df
nightlights_raw_adm2 <- 
  raster::extract(nl_prk_2, prk_adm2, method='bilinear', df=T) %>% 
  mutate_if(is.numeric, funs(ifelse(. == 0 | . == 63, NA, .))) %>% # transform 0s and 63 (oversaturation) to NA
  mutate(id=ID-1) %>% # easier joining later on
  select(-ID) # drop old ID variable

# Figure 2: histogram (taking out the inflated 0 value pixels)
nightlights_raw_adm2 %>% 
  pull(light_value_2013) %>% 
  hist(xlab='Light Value', 
       main='Figure 2. Histogram of light value distribution \n in North Korea on regional level in 2013')

# extract most important location parameters and statistics per cities for every year
nightlights_agg_adm2_yearly <- 
  nightlights_raw_adm2 %>% 
  group_by(id) %>% 
  summarise_all(.funs=funs(mean(., na.rm=T), 
                           median(., na.rm=T),
                           sum(., na.rm=T),
                           var(., na.rm=T),
                           first_q=quantile(., 0.25, na.rm=T),
                           third_q=quantile(., 0.75, na.rm=T)))

# to further explore the development over the years, I need to calculate annual change rate of night light in North Korea
# transform dataframe for all years from wide to long format
nightlights_raw_adm2_long <- 
  nightlights_raw_adm2 %>% 
  gather(key='year', value=light_value, factor_key=T, -id) %>% 
  mutate(year=gsub('light_value_', '', year) %>% as.integer())

# create variables explaining development of night light over the years
nightlights_agg_adm2_ts <- 
  nightlights_raw_adm2_long %>% 
  group_by(id, year) %>% 
  summarise_all(.funs=funs(ymean=mean(., na.rm=T), 
                           ysum=sum(., na.rm=T))) %>% # create mean and sum per year and id
  mutate(ysum=ifelse(ysum==0, 1e-9, ysum)) %>% # avoid 0 in fractions
  group_by(id) %>% 
  mutate(agr=ysum/lag(ysum)-1, # annual growth rate
         ad=abs(ysum-lag(ysum))) %>% # absolute difference 
  summarise(mean_var=var(ymean, na.rm=T), # calculate variance over the years
            sum_var=var(ysum, na.rm=T), 
            agr_var=var(agr, na.rm=T),
            aagr=mean(agr, na.rm=T), # average annual growth rate
            ad_var=var(ad, na.rm=T),
            aad=mean(ad, na.rm=T)) # average annual absolute difference

# create other general variables explaining development over the years
nightlights_agg_adm2_at <- 
  nightlights_raw_adm2_long %>% 
  group_by(id) %>% 
  summarise(mean_at=mean(light_value, na.rm=T), 
            median_at=median(light_value, na.rm=T),
            sum_at=sum(light_value, na.rm=T),
            var_at=var(light_value, na.rm=T),
            first_q_at=quantile(light_value, 0.25, na.rm=T),
            third_q_at=quantile(light_value, 0.75, na.rm=T),
            n_obs=n()) # number of observations did not change over the years

# unite these 3 feature types and join it into one single data.frame 
nightlights_agg_adm2 <- 
  nightlights_agg_adm2_yearly %>% 
  left_join(nightlights_agg_adm2_at, by='id') %>% 
  left_join(nightlights_agg_adm2_ts, by='id')


# join nightlights onto ongoing dataframe for regions and create df for modeling
prk_adm2_df %<>% 
  left_join(nightlights_agg_adm2, by='id') 

(prk_model_2_df <- 
    prk_adm2_df %>% 
    select(-long, -lat, -order, -hole, -piece, -group) %>% # drop polygon plotting specific variables
    unique() %>% 
    mutate_if(is.numeric, funs(ifelse(is.na(.) | is.nan(.), 0, .))) # substitute NaNs and NAs
)  


# drop near zero variance
nzv <- nearZeroVar(prk_model_2_df)

# Figure 3. plot average annual growth rate (aagr) model
nl_plot_adm2 <- 
  ggplot(prk_adm2_df, aes(x=long, y=lat)) +
  geom_polygon(colour='black', size=0.5, 
               aes(group=group, fill=aagr)) + 
  map_theme + 
  ggtitle(label='Figure 3. AAGR of night lights per region', subtitle='Not normalized') +
  theme(legend.position='bottom', legend.key.size=unit(0.5, 'cm'), 
        legend.text=element_text(size=unit(5, 'cm')), 
        legend.title=element_text(size=unit(5, 'cm'))) + 
  scale_fill_gradientn(colours = rev(BuYlRd.11.p(100)),
                       name = 'AAGR of Night Lights   ') + 
  coord_equal()

grid.arrange(nl_plot_adm2)