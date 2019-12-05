/* Verify user step one */
final String addUser = r"""
  mutation verifyUser(
    $emails: String!, 
    $first_names: String!,
    $mid_names: String!,
    $last_names: String!,
    $descriptions: String!,
    $genders: String!,
    $profile_imgs: String!,
    $Occupations: String!,
    $Countrys: String!,
    $Nationalitys: String!,
    $Citys: String!,
    $CountryCodes: String!,
    $PhoneNumbers: String!,
    $BuildingNumbers: String!,
    $Addresses: String!,
    $PostalCodes: String!
  ){
  verifyUser(
    email: $emails,
    first_name: $first_names,
    mid_name: $mid_names,
    last_name: $last_names,
    description: $descriptions,
    gender: $genders,
    profile_img: $profile_imgs,
    Occupation: $Occupations,
    Country: $Countrys,
    Nationality: $Nationalitys,
    City: $Citys,
    CountryCode: $CountryCodes,
    PhoneNumber: $PhoneNumbers,
    BuildingNumber: $BuildingNumbers,
    Address: $Addresses,
    PostalCode: $PostalCodes,
    ) {
      email,
      first_name,
      mid_name,
      last_name,
      description,
      gender,
      profile_img,
      Occupation,
      Country,
      Nationality,
      City,
      CountryCode,
      PhoneNumber,
      BuildingNumber,
      Address,
      PostalCode
    }
  }
""";

/* Verify user step two */
final String addDocument = r"""
  mutation addDocument(
    $emails: String!,
    $document_noes: String!,
    $documenttype_ids: String!,
    $documents_uris: String!,
    $face_uris: String!,
    $issue_dates: String!,
    $expire_dates: String!
  ){
    addDocuments(
      email: $emails,
      document_no: $document_noes,
      documenttype_id: $documenttype_ids,
      documents_uri: $documents_uris,
      face_uri: $face_uris,
      issue_date: $issue_dates,
      expire_date: $expire_dates 
    ) {
      id
    }
  }
""";

/* Claim Wallet */
final String getWallet = r"""
  mutation getWallet(
    $pins: String! 
  ){
    createAccount(pin: $pins){
      id
      wallet,
      message
    }
  }
""";

/* Scan Pay */
final String scanPay = r"""
  mutation payment(
    $pins: String!,
    $assets: String!,
    $wallets: String!,
    $amounts: String!,
    $memoes: String!
  ){
    payment(
      pin: $pins,
      asset: $assets,
      wallet: $wallets,
      amount: $amounts,
      memo: $memoes
    ){
      message
    }
  }
""";
