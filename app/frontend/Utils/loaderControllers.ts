export const showLoader = (): void => {
  document.getElementsByClassName('loading-widget')[0]?.classList.remove('hidden');
};

export const hideLoader = (): void => {
  document.getElementsByClassName('loading-widget')[0]?.classList.add('hidden');
  document.getElementsByClassName('page-slow-popup')[0]?.classList.add('hidden');
};
