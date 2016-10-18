Query "query"
  = 'select'i SetQuantifier? __ {
    return {
      type: 'SelectStmt'
    };
  }

SetQuantifier "quantifier"
  = _ label:( 'distinct'i / 'all'i ) {
    return label;
  }

_ "whitespace"
  = [ \t\n\r]+

__ "trailing whitespace"
  = [ \t\n\r]*
