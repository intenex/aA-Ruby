import React from 'react';
import StepListItemContainer from './step_list_item_container';
import StepForm from './step_form';

const StepList = ({steps, todoId}) => (
  <div>
    <ul>
      {steps.map((step, idx) => <StepListItemContainer step={step} key={idx}/>)}
    </ul>
    <StepForm todoId={todoId}/>
  </div>
);

export default StepList;