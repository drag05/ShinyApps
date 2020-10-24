# BalticSeaModules
This app is on its way to becoming a package. 
At current stage, the app covers one week in the Baltic Sea naval traffic between the 13-th and the 20-th of December 2016, tracking the movement of various ships through geographic location signals retrieved from ship's **A**ir **I**nteligence **S**ervice (AIS). 
The information is made avaliable through two interactive tables: the "Map" table and the "Data" table.
The source data contains calculated geodesic distances (to WGS84 geodetic Datum) and plots the maximum distance covered by ship between signals (MaxDBS), measured in meters, whether the ship is parked or not.
Selecting the date interval, ship type and ship name brings the ship's path shown as patterned geographic coordinates (points) on a GCS map. 
Where present, the red dots locate the end-points of MaxDBS path segment for respective ship; hovering over the less transparent point brings up a label showing ship's name and MaxDBS for respective case. MaxDBS is also shown in the Legend at map's bottom-left.
Multiple paths (hence, multipls MaxDBSs), corresponding to the same ship are possible when a range of dates is selected.
The facetted plot on the right side of the map depicts the total distance (in meters) covered in any day of the week by each ship type. Some date ranges were cached to disk for faster processing of the plot.
Information filtered by dates, ship type and ship name is collected in the "Data" table which can be downloaded as `csv` file.
