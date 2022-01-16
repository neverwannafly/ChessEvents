const extractKeys = (source = []) => {
  const obj = {};
  source.forEach(row => obj[row.key] = '');

  return obj;
};

export const signupFormFields = [
  { label: 'Username', key: 'username' },
  { label: 'Email', key: 'email' },
  { label: 'Password', key: 'password' },
];

export const signinFormFields = [
  { label: 'Username', key: 'username' },
  { label: 'Password', key: 'password' },
];

export const signupFormKeys = extractKeys(signupFormFields);
export const signinFormKeys = extractKeys(signinFormFields);

export const formValidators = {
  username: () => {

  },
  password: () => {

  },
  email: () => {

  },
};
