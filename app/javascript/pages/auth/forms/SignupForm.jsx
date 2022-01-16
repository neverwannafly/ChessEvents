import React, { useCallback } from 'react';
import { useHistory } from 'react-router-dom';

import useForm from '@app/hooks/useForm';
import { signupFormFields, signupFormKeys } from '@app/constants/auth';
import AuthForm from './AuthForm';

function SignupForm() {
  const {
    handleFieldUpdate,
    handleSubmit,
  } = useForm({
    baseUrl: '/api/registrations',
    formFields: signupFormKeys,
    handleSuccess: (data) => console.log(data),
    handleError: (er) => console.log(er),
  });
  const history = useHistory();
  
  const handleFormSwitch = useCallback(() => {
    history.push('/auth/signin');
  }, [history]);

  return (
    <AuthForm
      handleUpdate={handleFieldUpdate}
      handleSubmit={handleSubmit}
      formActionLabel="Register"
      formSwitchLabel="Have an account?"
      formFields={signupFormFields}
      handleFormSwitch={handleFormSwitch}
    />
  );
}

export default SignupForm;
