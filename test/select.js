const { parse } = require('../index.js');

describe('Sequela SQL parser', () => {
    describe('SELECT', () => {
        it('should parse a very simple select', () => {
            parse('select 1 from stj');
        });
    });
});
