import React from 'react';

const MonthlyUsesField = props => {
  let monthsPerProduct = "On average, how many months does this product last you?"
  const months = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18"]

  let monthInput = months.map(number => {
    return(
      <option key={number} value={number}>
        {number}
      </option>
    )
  })

  return (
    <div>
      <h6>{monthsPerProduct}</h6>
      <select onChange={props.handlerFunction}>{monthInput}</select>
    </div>
  );
}

export default MonthlyUsesField;
