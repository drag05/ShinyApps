# ShinyApps
This app covers one week of Baltic Sea traffic in December 2016. 
The source data contains already calculated geodesic distances (to the WGS84 geodetic Datum) retrieved from ship's AIC-signaled geographic locations, and plots the maximum distance between signals (MaxDBS) measured in meters, whether the ship is parked or not.
Select date interval, ship type and ship name. As result, the ship path is shown as geographic coordinates (points) in a GCS map.
The facetted plot depicts the total distance (in meters) covered in any day of the week by ship type. Some date ranges were cached to disk for faster processing.
The data table shows some information filtered by date, ship type and ship name. The data can be downloaded as .csv file.
