import React from 'react';

const WeeklyUsesField = props => {
  let usesPerWeek = "On average, how many times do you use this product per week?"

  let weekInput = [1, 2, 3, 4, 5, 6, 7].map(number => {
    return(
      <div key={number} className="product-lifespan-radio-buttons">
        <label className="radio-buttons">{number}</label>
        <input
          name='product-lifespan'
          onChange={props.handlerFunction}
          type='radio'
          value={number}
        />
      </div>
    )
  })

  return (
    <div>
      <h6>{usesPerWeek}</h6>
      {weekInput}
    </div>
  );
}

export default WeeklyUsesField;
