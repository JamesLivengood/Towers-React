// Display loading icon
export const showLoader = () => {
  document.getElementsByClassName("loading-widget")[0].classList.remove("hidden");
}

// Hide loading icon
export const hideLoader = () => {
  document.getElementsByClassName("loading-widget")[0].classList.add("hidden");
  document.getElementsByClassName("page-slow-popup")[0].classList.add("hidden");
}
