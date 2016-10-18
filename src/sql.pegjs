Query "query"
  = 'select'i SetQuantifier? fields:SelectList __ {
    return {
      type: 'SelectStmt',
      fields: fields
    };
  }

SelectList "select list"
  = _ items:( '*' { return ['*'] } ) {
    return items;
  }

SetQuantifier "quantifier"
  = _ label:( 'distinct'i / 'all'i ) {
    return label;
  }

_ "whitespace"
  = [ \t\n\r]+

__ "trailing whitespace"
  = [ \t\n\r]*
