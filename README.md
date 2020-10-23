# ShinyApps
This app covers one week of Baltic Sea traffic in December 2016. 
The source data contains already calculated geodesic distances (to WGS84 geodetic Datum) retrieved from ship's **A**ir **I**nteligence **S**ervice-signaled geographic locations, and plots the maximum distance covered by ship between signals (MaxDBS), measured in meters, whether the ship is parked or not.
Selecting the date interval, ship type and ship name brings the ship's path shown as patterned geographic coordinates (points) on a GCS map. 
The red dots represent the end-points of MaxDBS in each case; hovering over the less transparent point brings up a label showing ship's name and MaxDBS for respective case. MaxDBS is also shown in the Legend at map's bottom-left.
The facetted plot on the right side depicts the total distance (in meters) covered in any day of the week by each ship type. Some date ranges were cached to disk for faster processing of the plot.
Information filtered by dates, ship type and ship name is collected in the "Data" table which can be downloaded as `csv` file.
