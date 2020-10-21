# ShinyApps
This app covers one week of Baltic Sea traffic in December 2016. 
The source data contains already calculated geodesic distances (to the WGS84 geodetic Datum) retrieved from ship's AIC-signaled geographic locations, and plots the maximum distance between signals (MaxDBS) measured in meters whether the ship is parked or not.
Select date interval, ship type and ship name. As result, ship's path is shown as patterned geographic coordinates (points) in a GCS map. The red dots represent the end-points of MaxDBS in each case.
The facetted plot on the right depicts the total distance (in meters) covered in any day of the week by ship type. Some date ranges were cached to disk for faster processing of the plot.
Information filtered by date, ship type and ship name is collected in the "Data" table which can be downloaded as .csv file.
