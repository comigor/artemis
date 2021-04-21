const schema = r'''
enum SomeEnum {
  e1
  e2
}

input Input {
  i: String
  e: SomeEnum
  s: SubInput
}

input SubInput {
  s: String
}

type Thing {
  id: String
  e: SomeEnum
  aThing: Thing
  bThing: Thing
  fThing: Thing
}

type Query {
  thing(input: Input!): Thing
}
''';

const query = r'''
query big_query($input: Input!) {
  thing(input: $input) {
    e
    ... on Thing {
      id
    }
    ...parts
    aThing {
      id
    }
    bThing {
      id
    }
    aliasOnAThing: aThing {
      id
    }
  }
  aliasOnThing: thing(input: $input) {
    e
    ... on Thing {
      id
    }
    ...parts
    aThing {
      id
    }
    bThing {
      id
    }
    aliasOnAThing: aThing {
      id
    }
  }
}

fragment parts on Thing {
  id
  fThing {
    id
  }
  aliasOnFThing: fThing {
    id
  }
}
''';
