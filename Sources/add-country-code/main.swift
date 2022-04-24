import Contacts

func addCountryCode(_ countryCode: String, previewOnly: Bool) throws {
  let store = CNContactStore()
  let request = CNContactFetchRequest(keysToFetch: [
    CNContactGivenNameKey as CNKeyDescriptor,
    CNContactFamilyNameKey as CNKeyDescriptor,
    CNContactPhoneNumbersKey as CNKeyDescriptor]
  )
  let saveRequest = CNSaveRequest()
  
  try store.enumerateContacts(with: request) { contact, stop in
    let contact = contact.mutableCopy() as! CNMutableContact
    for i in 0..<contact.phoneNumbers.count {
      let number = contact.phoneNumbers[i].value.stringValue;
      if !number.hasPrefix("+") {
        let newNumber = "+" + countryCode + number
        print(contact.givenName, contact.familyName, number, "->", newNumber)
        if !previewOnly {
          contact.phoneNumbers[i] = contact.phoneNumbers[i]
            .settingValue(CNPhoneNumber(stringValue: newNumber))
          saveRequest.update(contact)
        }
      }
    }
  }
  try store.execute(saveRequest)
}

print("Country code: +", terminator: "")
guard let countryCode = readLine(), Int(countryCode) != nil else {
  print("error: wrong country code")
  exit(1)
}
try addCountryCode(countryCode, previewOnly: false)
