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
  nextThing: Thing
  nextThingOnFragment: Thing
}

type Query {
  thing(input: Input!): Thing
}
''';

const query = r'''
query big_query($input: Input!) {
  thing(input: $input) {
    e
    ...parts
    nextThing {
      id
    }
    aliasOnNextThing: nextThing {
      id
    }
  }
  aliasOnThing: thing(input: $input) {
    e
    ...parts
    nextThing {
      id
    }
    aliasOnNextThing: nextThing {
      id
    }
  }
}

fragment parts on Thing {
  id
  nextThingOnFragment {
    id
  }
  aliasOnNextThingOnFragment: nextThingOnFragment {
    id
  }
}
''';
