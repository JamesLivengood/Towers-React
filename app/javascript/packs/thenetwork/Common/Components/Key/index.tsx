import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faTimes, faPlus, faMinus } from '@fortawesome/free-solid-svg-icons';

const Key = ({ adjustMarkerSizeMultiplier }) => {
  const hideKey = () => {
    document.getElementsByClassName("key")[0].classList.add("hidden");
  }

  return (
    <span className="key">
      <FontAwesomeIcon icon={faTimes} className="x" onClick={hideKey}/>

      <div className="mb-10x flex align-center">
        <img className="h-20x mr-3x" src="http://maps.google.com/mapfiles/ms/icons/red-dot.png" />
        <span>Tower</span>
      </div>

      <div className="mb-10x flex align-center">
        <img className="h-20x mr-3x" src="http://maps.google.com/mapfiles/ms/icons/blue-dot.png" />
        <span>Single Antenna</span>
      </div>

      <div className="mb-10x flex align-center">
        <img className="h-20x mr-3x" src="http://maps.google.com/mapfiles/ms/icons/yellow-dot.png" />
        <span>Multiple Antennas</span>
      </div>

      <div className="mb-10x flex align-center">
        <img className="h-20x mr-3x" src="http://maps.google.com/mapfiles/ms/icons/green-dot.png" />
        {/* <img className="h-20x mr-3x" src="https://www.freeiconspng.com/uploads/person-icon-user-person-man-icon-4.png" /> */}
        <span>Searched Location</span>
      </div>

      <div className="flex justify-center marker-size-adjuster">
        <span className="round-left">
          <FontAwesomeIcon icon={faMinus} className="decrease-size" onClick={adjustMarkerSizeMultiplier}/>
        </span>
        <span className="round-right">
          <FontAwesomeIcon icon={faPlus} className="increase-size" onClick={adjustMarkerSizeMultiplier}/>
        </span>
      </div>
    </span>
  );
};

export default Key;
