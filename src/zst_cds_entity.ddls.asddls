@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS ENTITY'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
          serviceQuality: #X,
          sizeCategory: #S,
          dataClass: #MIXED
          }
define view entity ZST_CDS_ENTITY as select from I_Country
{
    key Country,
    CountryThreeLetterISOCode,
    CountryThreeDigitISOCode,
    CountryISOCode,
    IsEuropeanUnionMember,
    BankAndBankInternalIDCheckRule,
    BankInternalIDLength,
    BankInternalIDCheckRule,
    BankNumberLength,
    BankCheckRule,
    BankAccountLength,
    BankPostalCheckRule,
    BankDataCheckIsCountrySpecific,
    /* Associations */
    _Text
}
