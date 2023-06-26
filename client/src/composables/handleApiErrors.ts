type ErrorsObject = { [key: string]: string }

const sortErrors = (errors: string[] | null, fields: string[]): ErrorsObject => {
  const errs: ErrorsObject = {}

  errors?.forEach((err: string) => {
    let isSorted = false

    for (let i = 0; !isSorted || i > errors.length; i++) {
      if (err.toLowerCase().includes(fields[i])) {
        errs[fields[i].toString()] = err
        isSorted = true
      }
    }
  })

  return errs
}

const handleApiErrors = (error: any, ...fields: string[]): ErrorsObject => {
  const message: string = error.response.data.message || error.message

  const errors = sortErrors(error.response.data.errors as string[] | null, fields)

  const values: string[] = errors ? Object.values(errors) : []

  // eslint-disable-next-line no-console
  console.log(`An error occured: ${message} ${values.join(", ")}`)

  return errors
}

export default handleApiErrors
