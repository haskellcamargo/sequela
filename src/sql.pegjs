/**
 * TODO: Implement unicode support for identifiers
 */

Query "query"
  = 'select'i SetQuantifier? fields:SelectList __ {
    return {
      type: 'SelectStmt',
      fields: fields
    };
  }

SelectList "select list"
  = _
    first:( '*' / SelectSublist )
    rest:( __ ',' __ item:SelectSublist { return item; } )* {
    return [first].concat(rest);
  }

SelectSublist "select sublist"
  = DerivedColumn
  / QualifiedAsterisk

DerivedColumn "derived column"
  = value:ValueExpr asClause:AsClause? {
    return {
      field: value,
      alias: asClause
    };
  }

QualifiedAsterisk "qualified asterisk"
  = chain:IdentifierChain '.' '*' {
    return chain.concat('*');
  }
  / AllFieldsReference

AllFieldsReference "all fields reference"
  = field:ValueExprPrimary '.' '*'
    ls:(_ 'as'i _ '(' __ columns:ColumnNameList __ ')' { return columns; } )? {
      return {
        field: [field, '*'],
        alias: ls
      };
    }

ColumnNameList "column name list"
  = first:Identifier rest:( __ ',' __ item:Identifier { return item; } )* {
    return [first].concat(rest);
  }

AsClause "as clause"
  = _ "as"i _ name:Identifier { return name; }

ValueExpr "TODO"
  = '1'

ValueExprPrimary "TODO"
  = '2'

SetQuantifier "quantifier"
  = _ label:( 'distinct'i / 'all'i ) {
    return label;
  }

IdentifierChain "identifier chain"
  = first:Identifier rest:( '.' name:Identifier { return name; } )* {
    return [first].concat(rest);
  }

Identifier "identifier"
  = RegularIdentifier / DelimitedIdentifier

RegularIdentifier
  = start:[a-z]i rest:[a-z0-9]i* {
    return [start].concat(rest).join('');
  }

DelimitedIdentifier
  = '"' name:RegularIdentifier '"' { return name; }

_ "whitespace"
  = [ \t\n\r]+

__ "trailing whitespace"
  = [ \t\n\r]*
