// @dart = 2.8

const schema = r'''
enum Enum {
  e1
  e2
}

input Input {
  i: String
  e: Enum
  s: SubInput
}

input SubInput {
  s: String
}

type Thing {
  id: String
  e: Enum
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
