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
![Rplot](https://user-images.githubusercontent.com/93341531/178819201-e5c7a088-bcd0-4cc8-a91b-cd23448e86d6.jpeg)

The Figure 1. presents a visualization of average annual growth rate (aagr) of night light in North Korea by region for the period 2004–2018. 

### Inference1_A growing economic gap between Pyongyang and other areas
The Figure 1. illustrates growing differences in nighttime lights between the capital Pyongyang and the rest of the country. 
In North Korea, Pyongyang has priviliges over other areas. Only those who showed loyalty to the regime are allowed to live in Pyongyang. The citizens of Pyongyang are given priority in food, electricity, and other necessary items. In response to the strengthening of sanctions against North Korea from 1992 to 2013, the North Korean regime concentrated limited resources to key regions to maximize the political interests of the regime (김다울, 2021). *Lee, Yong Suk(2018)* found that the difference in nighttime lights between the capital Pyongyang and the rest of the country increases by 1.9% with every additional sanction. 
The Figure 1. further corroborates a claim that the regime is diverting resources and electricity to Pyongyang when sanctions increase resulting in limited resources. 

### Inference2_Decreasing economic growth due to increased sanctions
The Figure 1. also shows increased nighttime lights in border villages like Sinuiju and Hyesan-si; however, this does not necessarily mean that the border villages have experienced economic developments. The satellite nighttime lights data tends to spreads to the surrounding areas. Therefore, increased aagr of night light in border villages represents increased socioeconomic development of Chinese villages not North Korean villages. Figure 2. more clearly illustrates that increased aagr of night light in border is primarily due to the increased luminosity in China.

![norht korea light in 2015](https://user-images.githubusercontent.com/93341531/178825017-3f70a87c-f1b9-462f-8728-885f40aaae25.jpg)

**Fig 2. North Korea: average yearly night-time luminosity. Sources: Earth Observation Group, NOAA/NCEI, 2015 VIIRS DNB yearly product. Mask DLRWorld
Settlement Footprint 2015. Base map: GADM.**

The fact that Sinuiju(a border village between North Korea-China) is the village that experienced the greatest increase of night light in North Korea implies that socioeconomic development of North Korea has been sluggish from 2004-2013. *김다울(2021)* wrote that socioeconomic gaps between Pyongyang and non-Pyongyang areas, border and non-border, urban and rural have narrowed. However this does not imply improved economic level of low-income regions but rather as a result of fast decline in the economic level of high-income regions in North Korea. 


## Citation
Lee, Yong Suk. "International isolation and regional inequality: Evidence from sanctions on North Korea." Journal of Urban Economics 103 (2018): 34-51.

김다울, “Essays on Regional Economy of North Korea”, 서울대학교 박사학위논문, 2021.

김다울, “지역 간 격차로 본 김정은 정권 10년”, 대외경제정책연구원, 2021.

Cuaresma, J.C.; Danylo, O.; Fritz, S.; Hofer, M.; Kharas, H.; Bayas, J.C.L. What do we know about poverty in North Korea? Palgr. Commun. 2020, 6, 1–8.
