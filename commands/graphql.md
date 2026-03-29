---
description: GraphQL development patterns
---

GraphQL development helper.

## Schema Definition

```graphql
type User {
  id: ID!
  email: String!
  name: String
  posts: [Post!]!
  createdAt: DateTime!
}

type Post {
  id: ID!
  title: String!
  content: String
  author: User!
  published: Boolean!
}

type Query {
  user(id: ID!): User
  users: [User!]!
  post(id: ID!): Post
  posts(published: Boolean): [Post!]!
}

type Mutation {
  createUser(input: CreateUserInput!): User!
  updateUser(id: ID!, input: UpdateUserInput!): User!
  deleteUser(id: ID!): Boolean!
}

input CreateUserInput {
  email: String!
  name: String
}
```

## Apollo Server (Next.js)

```typescript
// app/api/graphql/route.ts
import { ApolloServer } from '@apollo/server'
import { startServerAndCreateNextHandler } from '@as-integrations/next'

const typeDefs = `#graphql
  type Query {
    hello: String
  }
`

const resolvers = {
  Query: {
    hello: () => 'Hello World!'
  }
}

const server = new ApolloServer({ typeDefs, resolvers })
const handler = startServerAndCreateNextHandler(server)

export { handler as GET, handler as POST }
```

## Apollo Client

```typescript
// lib/apollo.ts
import { ApolloClient, InMemoryCache, HttpLink } from '@apollo/client'

export const client = new ApolloClient({
  link: new HttpLink({ uri: '/api/graphql' }),
  cache: new InMemoryCache()
})

// Usage with hooks
import { useQuery, useMutation, gql } from '@apollo/client'

const GET_USERS = gql`
  query GetUsers {
    users {
      id
      name
      email
    }
  }
`

function Users() {
  const { data, loading, error } = useQuery(GET_USERS)
  if (loading) return <Loading />
  return <UserList users={data.users} />
}
```

## Mutations

```typescript
const CREATE_USER = gql`
  mutation CreateUser($input: CreateUserInput!) {
    createUser(input: $input) {
      id
      name
      email
    }
  }
`

function CreateUserForm() {
  const [createUser, { loading }] = useMutation(CREATE_USER, {
    refetchQueries: [{ query: GET_USERS }]
  })

  const handleSubmit = async (data) => {
    await createUser({ variables: { input: data } })
  }
}
```

## Code Generation

```bash
bun add -d @graphql-codegen/cli @graphql-codegen/typescript

# codegen.ts
import { CodegenConfig } from '@graphql-codegen/cli'

const config: CodegenConfig = {
  schema: './schema.graphql',
  documents: ['src/**/*.tsx'],
  generates: {
    './src/gql/': {
      preset: 'client'
    }
  }
}
```
