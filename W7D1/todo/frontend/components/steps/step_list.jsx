import React from 'react';
import StepListItemContainer from './step_list_item_container';
import StepForm from './step_form';

const StepList = ({steps, todo}) => (
  <div>
    <ul>
      {steps.map((step, idx) => <StepListItemContainer key={idx}/>)}
    </ul>
    <StepForm todo={todo}/>
  </div>
);

export default StepList;