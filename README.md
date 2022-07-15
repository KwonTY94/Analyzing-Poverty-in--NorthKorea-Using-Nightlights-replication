# Analyzing-Regional-Poverty-in-NorthKorea-Using-Nightlights-replication
The purpose of this repository is to visualize the work of Jesús Crespo Cuaresma(2020) and 김다울(2021) using R. The project is based on the work of FABI BRU on different setting.
The goal of the paper is to use satellite imagery and nightlights data to predict poverty levels at a local level in North Korea. 

## Introduction
Obtaining any quantitative information on the North Korean economy is notoriously difficult. However, the availability of satellite data on night-time light emissions and other observable terrain characteristics has opened new possibilities in terms of understanding and visualizing socioeconomic developments in North Korea. The analysis uses night-time light emission data from 2004 to 2013 to estimate economic development and regional disparities of North Korea.



## Data Sources
These are sources where I got the data from:

1. Country shape file: gadm.org
2. Night Light Values : https://www.kaggle.com/datasets/fbruckschen/nightlights
  (Night light observations as seen from space for all over the world. Spans the years 2004 until including 2013. One .tif file per year.)
  
## Reproduction Results

![Night light of North Korea 2004-2013](https://user-images.githubusercontent.com/93341531/179265707-3bd3b7a1-3399-4c36-baf4-1332a9cafd9f.jpeg)
**Figure 1. Visualization of night light development in North Korea for the period
2004–2018**

![figure2](https://user-images.githubusercontent.com/93341531/179265855-6c1fdbef-472c-4498-b64f-74557f983a3d.jpeg)

### A growing economic gap between Pyongyang and non-Pyongyang areas
*Figure 1.* illustrates the development of the night lights in North Korea from 2004 to 2013, and *Figure 2.* presents the histogram of luminosity distribution in North Korea for 2013. In both figures, the dynamics of luminosity present highly skewed night-time light developments throughout the country. Unlike the villages of China and South Korea, the night-time light intensity in North Korea had significant increase only in Pyongyang.
Moreover, the scope of increased radiance intensity is limited, which corroborates the assumption that the North Korean regime is diverting resources and electricity to Pyongyang as sanctions increase, thus further widening economic disparities between Pyongyang and non-Pyongyang areas.

![figure3](https://user-images.githubusercontent.com/93341531/179266365-e4e79960-edc1-48e6-ba6b-ea1a53ee6029.jpeg)

### Decreasing economic growth due to increased sanctions
*Figure 3.* presents a visualization of the average annual growth rate (AAGR) of night light in North Korea by region for the period 2004–2018. According to *Figure 3.* radiance intensity especially increased in border villages like Sinuiju and Hyesan-si; however, this does not necessarily mean that the border villages have experienced economic developments. The satellite nighttime light data tends to spread to the surrounding areas. Therefore, the high AAGR of night light in border villages is likely to represent increased socioeconomic development of Chinese villages not North Korean villages (김규철, 2021). 

The fact that Sinuiju(a border village between North Korea-China) is the village that experienced the greatest increase in night light intensity in North Korea implies that the socioeconomic development of North Korea, even including Pyongyang, has been slower than that of a border village of China. Unlike the hypothesis, the analysis failed to find significant increases in the light radiance of manufacturing or mining regions of North Korea. 김다울 (2021). wrote that socioeconomic gaps between urban and rural have narrowed. As a result of a fast decline in the economic level of high-income regions in North Korea, economic disparities between manufacturing and non-manufacturing regions have decreased. Therefore, manufacturing regions could not have experienced much increase in economic activity compared to other regions of the country.


## Citation
Lee, Yong Suk. "International isolation and regional inequality: Evidence from sanctions on North Korea." Journal of Urban Economics 103 (2018): 34-51.

김다울, “Essays on Regional Economy of North Korea”, 서울대학교 박사학위논문, 2021.

김다울, “지역 간 격차로 본 김정은 정권 10년”, 대외경제정책연구원, 2021.

Cuaresma, J.C.; Danylo, O.; Fritz, S.; Hofer, M.; Kharas, H.; Bayas, J.C.L. What do we know about poverty in North Korea? Palgr. Commun. 2020, 6, 1–8.
