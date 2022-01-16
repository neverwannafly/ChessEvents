import { useCallback, useState } from 'react';

import apiRequest from '@app/lib/api';

function useForm({
  baseUrl,
  formFields = {},
  formValidators = {},
  handleSuccess = () => {},
  handleError = () => {},
}) {
  const [formState, setFormState] = useState(formFields);
  console.log(formState);

  const handleSubmit = async (event) => {
    event.preventDefault();

    let isFormValid = true;

    Object.keys(formValidators).forEach(key => {
      const { isError, message } = formValidators[key](formState[key]);
      if (isError) {
        handleError(new Error(message));
        isFormValid = false;
        return;
      }
    });

    if (!isFormValid) {
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
  }, []);

  return {
    handleFieldUpdate,
    handleSubmit,
  }
}

export default useForm;
