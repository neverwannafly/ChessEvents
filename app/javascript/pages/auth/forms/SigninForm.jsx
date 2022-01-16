import React, { useCallback } from 'react';
import { useHistory } from 'react-router-dom';

import useForm from '@app/hooks/useForm';
import { signinFormFields, signinFormKeys } from '@app/constants/auth';
import AuthForm from './AuthForm';

function SignupForm() {
  const {
    handleFieldUpdate,
    handleSubmit,
  } = useForm({
    baseUrl: '/api/sessions',
    formFields: signinFormKeys,
    handleSuccess: (data) => console.log(data),
    handleError: (er) => console.log(er),
  });
  const history = useHistory();

  const handleFormSwitch = useCallback(() => {
    history.push('/auth/signup');
  }, [history]);

  return (
    <AuthForm
      handleUpdate={handleFieldUpdate}
      handleSubmit={handleSubmit}
      formActionLabel="Log in"
      formSwitchLabel="Create Account"
      formFields={signinFormFields}
      handleFormSwitch={handleFormSwitch}
      cardClassName="auth-form__card--right"
    />
  );
}

export default SignupForm;
