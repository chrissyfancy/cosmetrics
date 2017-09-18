import React from 'react';

const ProductLifespan = props => {
  let usesPerWeek = "On average, how many times do you use this product per week?"
  let monthsPerProduct = "On average, how many months does this product last you?"
  const months = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18"]

  let weekInput = [1, 2, 3, 4, 5, 6, 7].map(number => {
    return(
      <div className="product-lifespan-radio-buttons">
        <label className="radio-buttons">{number}</label>
        <input
          key={number}
          name='product-lifespan'
          onChange={props.handlerFunction}
          type='radio'
          value={number}
          />
      </div>
    )
  })

  let monthInput = months.map(number => {
    return(
      <option value={number}>{number}</option>
    )
  })

  return (
    <div>
      <h6>{usesPerWeek}</h6>
      {weekInput}
      <h6>{monthsPerProduct}</h6>
      <select>{monthInput}</select>
    </div>
  );
}

export default ProductLifespan;
