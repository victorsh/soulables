import { useEffect, useState } from 'react'

const Hello = () => {
  const [hello, setHello] = useState({})

  useEffect(() => {
    getHello()
  })

  const getHello = async () => {
    try {
      let res = await fetch(`${process.env.NEXT_PUBLIC_BASE_URL}/api/hello`)
      let name = await res.json()
      console.log(name)
      setHello(name)
    } catch (e) {
      console.error(e)
    }
  }

  return (
    <div>hi!{hello.name}</div>
  )
}

export default Hello