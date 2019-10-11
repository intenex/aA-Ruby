import React from 'react';
import StepListItemContainer from './step_list_item_container';
import StepForm from './step_form';

const StepList = ({steps}) => (
  <div>
    <ul>
      {steps.map((step, idx) => <StepListItemContainer key={idx}/>)}
    </ul>
    <StepForm />
  </div>
);

export default StepList;