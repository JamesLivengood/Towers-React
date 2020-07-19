// Display loading icon
export var showLoader = function () {
    document.getElementsByClassName("loading-widget")[0].classList.remove("hidden");
};
// Hide loading icon
export var hideLoader = function () {
    document.getElementsByClassName("loading-widget")[0].classList.add("hidden");
    document.getElementsByClassName("page-slow-popup")[0].classList.add("hidden");
};
//# sourceMappingURL=loaderControllers.js.map