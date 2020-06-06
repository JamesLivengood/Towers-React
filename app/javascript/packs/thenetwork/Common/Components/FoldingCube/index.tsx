import React, { useEffect } from 'react';

const FoldingCube = ({ displayFoldingCube }: { displayFoldingCube: boolean }) => {
  useEffect(() => {
    const timer = setTimeout(() => {
      document.getElementsByClassName("page-slow-popup")[0].classList.remove("hidden");
    }, 10000);
    return () => clearTimeout(timer);
  }, []);

  const hidePageSlowMessage = () => {
    document.getElementsByClassName("page-slow-popup")[0].classList.add("hidden");
  }

  return (
    <div className="loading-widget">
      <p className="page-slow-popup hidden" onClick={hidePageSlowMessage}>
        Page slow? Try zooming in a bit - too many markers slows down the map.
      </p>
      <div className={`sk-folding-cube ${displayFoldingCube ? '' : 'hidden'}`}>
        <div className="sk-cube1 sk-cube" />
        <div className="sk-cube2 sk-cube" />
        <div className="sk-cube4 sk-cube" />
        <div className="sk-cube3 sk-cube" />
      </div>
    </div>
  )
}

export default FoldingCube;
