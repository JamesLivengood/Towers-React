import axios from 'axios';
import { hideLoader } from './loaderControllers';
var fetchParams = function (bounds) {
    return "latmin=" + bounds.getSouthWest().lat() + "&latmax=" + bounds.getNorthEast().lat() + "&lngmin=" + bounds.getSouthWest().lng() + "&lngmax=" + bounds.getNorthEast().lng();
};
var activeNorthEastBound = null;
var activeSouthWestBound = null;
export var fetchTowers = function (setTowers, bounds) {
    var northEastBound = activeNorthEastBound = bounds.getNorthEast().lat(); // TODO: Lat and lng
    var southWestBound = activeSouthWestBound = bounds.getSouthWest().lat();
    axios.get("/api/towers?" + fetchParams(bounds)).then(function (res) {
        // console.log('Towers count: ', res.data.length);
        if (northEastBound === activeNorthEastBound || southWestBound === activeSouthWestBound) {
            // console.log("SWAG!!!!!!!");
            setTowers(res.data);
        }
    })
        .catch(function (error) {
        console.warn(error);
    });
};
export var fetchTransmitters = function (setTransmitters, bounds) {
    var northEastBound = activeNorthEastBound = bounds.getNorthEast().lat(); // TODO: Lat and lng
    var southWestBound = activeSouthWestBound = bounds.getSouthWest().lat();
    axios.get("/api/transmitters?" + fetchParams(bounds)).then(function (res) {
        // console.log('Transmitters count: ', res.data.length);
        if (res.data.length === 0)
            hideLoader();
        if (northEastBound === activeNorthEastBound || southWestBound === activeSouthWestBound) {
            console.log('setTransmitters', Date.now());
            setTransmitters(res.data);
            hideLoader();
        }
    })
        .catch(function (error) {
        console.warn(error);
    });
};
export var fetchSuccesfulDownloads = function (setSuccesfulDownloads, bounds) {
    axios.get("/api/succesful_downloads?" + fetchParams(bounds)).then(function (res) {
        setSuccesfulDownloads(res.data);
    })
        .catch(function (error) {
        console.warn(error);
    });
};
export var fetchFailedDownloads = function (setFailedDownloads, bounds) {
    axios.get("/api/failed_downloads?" + fetchParams(bounds)).then(function (res) {
        setFailedDownloads(res.data);
    })
        .catch(function (error) {
        console.warn(error);
    });
};
export var fetchAntennaSearch = function () {
    axios.get("http://www.antennasearch.com/sitestart.asp", {
        params: {
            reportname001: "antennacheck",
            statename001: "ny",
            cityname001: "nyc",
            Address001: "20+Grand+St%2C+Brooklyn%2C+NY+11211",
            latitude001: "40.7162890444501",
            longitude001: "-73.9662015090831",
            raditem: "002",
            reportname002: "antennacheck",
            statename002: "ny",
            cityname002: "nyc",
            Address002: "20+Grand+St%2C+New+York%2C+NY+10013",
            latitude002: "40.723008376158",
            longitude002: "-74.0049866970744",
            x: "45",
            y: "9",
            sourcepagename: "SrchAnt",
            cmdRequest: "process"
        }
    }).then(function (data) { return console.log(data); });
};
//# sourceMappingURL=fetches.js.map