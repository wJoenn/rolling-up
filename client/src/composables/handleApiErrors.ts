const handleApiErrors = (error: any): string[] => {
  let message: string = error.message
  let errors = [""]
  if (error.response.data.errors) errors = error.response.data.errors
  if (error.response.data.message) message = error.response.data.message

  // eslint-disable-next-line no-console
  console.log(`An error occured: ${message} ${errors.join(", ")}`)

  return errors
}

export default handleApiErrors
