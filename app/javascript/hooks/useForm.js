import { useCallback, useState } from 'react';

import apiRequest from '@app/lib/api';

function useForm({
  baseUrl,
  formFields = {},
  formValidators = {},
  handleSuccess = () => {},
}) {
  const [formState, setFormState] = useState(formFields);
  const [formErrors, setFormErrors] = useState({});

  const handleSubmit = async (event) => {
    event.preventDefault();

    let isFormValid = true;
    const errors = {};

    Object.keys(formFields).forEach(key => {
      if (formValidators[key]) {
        const { isError, error } = formValidators[key](formState[key]);
        if (isError) {
          errors[key] = error;
          isFormValid = false;
        }
      }
    });

    if (!isFormValid) {
      setFormErrors(errors);
      console.log(errors);
      return;
    }

    try {
      const response = await apiRequest('POST', baseUrl, formState);
      handleSuccess(response);
    } catch (err) {
      handleError(err);
    }
  }

  const handleFieldUpdate = useCallback((key) => (event) => {
    setFormState({ ...formState, [key]: event.target.value });
  }, [formState]);

  return {
    handleFieldUpdate,
    handleSubmit,
    formErrors,
  }
}

export default useForm;
