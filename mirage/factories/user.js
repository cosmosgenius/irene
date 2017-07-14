import { Factory, faker } from 'ember-cli-mirage';
import ENUMS from 'irene/enums';

export default Factory.extend({
  id (i) {
    return i+1;
  },

  username: faker.name.firstName,
  email: faker.internet.email,
  firstName: faker.name.firstName,
  lastName: faker.name.lastName,
  expiryDate: faker.date.future,
  projectCount: faker.random.number,
  hasGithubToken: faker.random.boolean,
  hasJiraToken: faker.random.boolean,
  limitedScans: false,
  scansLeft: faker.random.number,
  uuid: faker.random.number,
  socketId: faker.random.number,
  mfaMethod(){
    return faker.random.arrayElement(ENUMS.MFA_METHOD.VALUES);
  },

  lang(){
    return faker.random.arrayElement(["en"]);
  },

  namespaces(){
    var desc = [];
    for (var i = 0; i < 5; i++) {
      desc.push(faker.internet.domainName(2).split(" "));
    }
    return desc.join(",");
  }

});
