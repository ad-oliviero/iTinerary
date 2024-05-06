//
//  CommonStructs.swift
//  iTravel
//
//  Created by Adriano Oliviero on 03/05/24.
//

import Foundation

// MARK: - DisplayableRequest
struct DisplayableRequest: Codable, Hashable {
  var displayName: String
  var requestValue: String

  enum CodingKeys: String, CodingKey {
    case displayName
    case requestValue
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(displayName)
    hasher.combine(requestValue)
  }

  init(_ displayName: String, _ requestValue: String) {
    self.displayName = displayName
    self.requestValue = requestValue
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    displayName = try container.decode(String.self, forKey: .displayName)
    requestValue = try container.decode(String.self, forKey: .requestValue)
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(displayName, forKey: .displayName)
    try container.encode(requestValue, forKey: .requestValue)
  }
}

// MARK: - GeoAPIfyData
struct GeoAPIfyData: Codable {
  let features: [Feature]?
  let type: String?
  let properties: GeoAPIfyDataProperties?
  let query: Query?
}

// MARK: - Feature
struct Feature: Codable {
  let properties: FeatureProperties?
  let geometry: Geometry?
  let type: FeatureType?
  let bbox: [Double]?
}

// MARK: - Geometry
struct Geometry: Codable {
  let coordinates: [GeometryCoordinate]?
  let type: GeometryType?
}

enum GeometryCoordinate: Codable {
  case double(Double)
  case unionArrayArray([[CoordinateCoordinate]])

  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if let x = try? container.decode([[CoordinateCoordinate]].self) {
      self = .unionArrayArray(x)
      return
    }
    if let x = try? container.decode(Double.self) {
      self = .double(x)
      return
    }
    throw DecodingError.typeMismatch(
      GeometryCoordinate.self,
      DecodingError.Context(
        codingPath: decoder.codingPath, debugDescription: "Wrong type for GeometryCoordinate"))
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    switch self {
    case .double(let x):
      try container.encode(x)
    case .unionArrayArray(let x):
      try container.encode(x)
    }
  }
}

enum CoordinateCoordinate: Codable {
  case double(Double)
  case doubleArray([Double])

  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if let x = try? container.decode([Double].self) {
      self = .doubleArray(x)
      return
    }
    if let x = try? container.decode(Double.self) {
      self = .double(x)
      return
    }
    throw DecodingError.typeMismatch(
      CoordinateCoordinate.self,
      DecodingError.Context(
        codingPath: decoder.codingPath, debugDescription: "Wrong type for CoordinateCoordinate"))
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    switch self {
    case .double(let x):
      try container.encode(x)
    case .doubleArray(let x):
      try container.encode(x)
    }
  }
}

enum GeometryType: String, Codable {
  case multiPolygon = "MultiPolygon"
  case point = "Point"
  case polygon = "Polygon"
}

// MARK: - FeatureProperties
struct FeatureProperties: Codable {
  let lat, lon: Double?
  let mode, type: String?
  let range: Int?
  let traffic, id: String?
  let country: String?
  let countryCode: String?
  let state, county, city: String?
  let datasource: Datasource?
  let stateCode: String?
  let population: Int?
  let resultType, formatted, addressLine1, addressLine2: String?
  let countyCode, category: String?
  let timezone: Timezone?
  let plusCode, plusCodeShort: String?
  let rank: Rank?
  let placeID, postcode, suburb, name: String?
  let categories: [String]?
  let details: [FeatureTypeElement]?
  let wikiAndMedia: WikiAndMedia?
  let nameInternational: [String: String]?
  let nameOther: NameOther?
  let refOther: RefOther?
  let distance: Int?
  let network, ref: String?
  let featureType: FeatureTypeElement?

  enum CodingKeys: String, CodingKey {
    case lat, lon, mode, type, range, traffic, id, country
    case countryCode = "country_code"
    case state, county, city, datasource
    case stateCode = "state_code"
    case population
    case resultType = "result_type"
    case formatted
    case addressLine1 = "address_line1"
    case addressLine2 = "address_line2"
    case countyCode = "county_code"
    case category, timezone
    case plusCode = "plus_code"
    case plusCodeShort = "plus_code_short"
    case rank
    case placeID = "place_id"
    case postcode, suburb, name, categories, details
    case wikiAndMedia = "wiki_and_media"
    case nameInternational = "name_international"
    case nameOther = "name_other"
    case refOther = "ref_other"
    case distance, network, ref
    case featureType = "feature_type"
  }
}

// MARK: - Datasource
struct Datasource: Codable {
  let sourcename: Sourcename?
  let attribution: String?
  let license: String?
  let url: String?
  let raw: Raw?
}

// MARK: - Raw
struct Raw: Codable {
  let name: String?
  let osmID: Int?
  let boundary: String?
  let osmType: OsmType?
  let wikidata, wikipedia: String?
  let adminLevel: Int?
  let nameAr, nameAz, nameBa, nameBe: String?
  let nameBg, nameBr, nameBs, nameCA: String?
  let nameCS, nameCv, nameCy, nameDa: String?
  let nameDe, nameEl, nameEn, nameEo: String?
  let nameEs, nameEt, nameEu, nameFa: String?
  let nameFi, nameFr, nameFy, nameGl: String?
  let nameHe, nameHi, nameHr, nameHu: String?
  let nameHy, nameID, nameIs, nameIt: String?
  let nameJa, nameKa, nameKk, nameKo: String?
  let nameKu, nameLa, nameLt, nameLV: String?
  let nameMk, nameMn, nameMr, nameMS: String?
  let nameNl, nameNn, nameNo, nameOc: String?
  let nameOS, namePl, namePt, nameRo: String?
  let nameRu, nameSh, nameSk, nameSl: String?
  let nameSq, nameSr, nameSv, nameSw: String?
  let nameTh, nameTr, nameTt, nameUk: String?
  let nameUr, nameVi, nameZh, natural: String?
  let nameDsb, nameEXT, nameHsb, nameLmo: String?
  let nameNah, nameSzl, nameWar, altNameAz: String?
  let altNameBa, altNameBr, altNameCA, altNameCy: String?
  let altNameDa, altNameEl, altNameEn, altNameEo: String?
  let altNameEs, altNameEu, altNameFr, altNameFy: String?
  let altNameHi, altNameHr, altNameID, altNameIs: String?
  let altNameIt, altNameKa, altNameKo, altNameKu: String?
  let altNameMn, altNameMS, altNameNl, altNameNn: String?
  let altNameNo, altNameOc, altNameOS, altNamePt: String?
  let altNameRo, altNameRu, altNameSh, altNameSl: String?
  let altNameSq, altNameSr, altNameSw, altNameTh: String?
  let altNameTt, altNameVi, altNameZh, locNameDe: String?
  let altNameEXT, nameZhHans: String?
  let flag: String?
  let nameAb, nameAF: String?
  let nameAk: String?
  let nameAm, nameAn, nameAs, nameAy: String?
  let nameBI, nameBn, nameBo, nameCe: String?
  let nameCo, nameCR, nameCu, nameDv: String?
  let nameDz: String?
  let nameEe: String?
  let nameFf, nameFo, nameGa, nameGd: String?
  let nameGn, nameGu, nameGv, nameHT: String?
  let nameIa, nameIe, nameIo, nameJv: String?
  let nameKg, nameKi, nameKl, nameKM: String?
  let nameKn, nameKv, nameKw, nameKy: String?
  let nameLB, nameLg, nameLi, nameLn: String?
  let nameLo, nameMg, nameMi, nameMl: String?
  let nameMT, nameMy, nameNa, nameNe: String?
  let nameNv, nameOr, namePa, namePS: String?
  let nameQu, nameRm, nameRw, nameSa: String?
  let nameSc, nameSE, nameSg, nameSm: String?
  let nameSo, nameSs, nameSu, nameTa: String?
  let nameTe, nameTg, nameTk, nameTl: String?
  let nameTw: String?
  let nameTy, nameUg, nameUz: String?
  let nameVe: String?
  let nameVo, nameWa, nameWo, nameYi: String?
  let nameYo, nameZu, currency, intName: String?
  let nameAce, nameAls, nameAng, nameArc: String?
  let nameArz, nameAST, nameBar, nameBcl: String?
  let nameBpy, nameBug, nameBxr, nameCdo: String?
  let nameCeb, nameChr: String?
  let nameChy: String?
  let nameCkb, nameCrh, nameCsb, nameDIN: String?
  let nameDiq, nameEml, nameFrp, nameFrr: String?
  let nameFur, nameGag, nameGan, nameGrc: String?
  let nameHak, nameHaw: String?
  let nameHif: String?
  let nameIlo, nameJbo, nameKaa, nameKab: String?
  let nameKbd, nameKoi, nameKrc, nameLad: String?
  let nameLez, nameLij, nameLld, nameLtg: String?
  let nameLzh, nameMDF, nameMhr, nameMin: String?
  let nameMwl, nameMzn, nameNan, nameNap: String?
  let nameNDS, nameNew, nameNov, nameNrm: String?
  let nameNso, namePag, namePam, namePAP: String?
  let namePcd, namePdc, namePfl, namePih: String?
  let namePms, namePnb, namePnt, nameRmy: String?
  let nameRue, nameSah, nameScn: String?
  let nameSco: String?
  let nameSmn, nameSMS, nameSrn, nameStq: String?
  let nameTet, nameTok, nameTpi, nameTzl: String?
  let nameUdm, nameVec, nameVep, nameVls: String?
  let nameVro, nameWuu, nameXal, nameXmf: String?
  let nameYue, nameZea, timezone, iso31661: String?
  let population: Int?
  let startDate, nameNDSNl, oldNameVi, nameBatSmg: String?
  let nameCbkZam, nameMapBms, nameZhHant, nameRoaTara: String?
  let officialName, nameBeTarask, populationDate, iso31661Alpha2: String?
  let iso31661Alpha3: String?
  let defaultLanguage: String?
  let officialNameCS, officialNameDe, officialNameEl, officialNameEo: String?
  let officialNameZh: String?
  let iso31661Numeric: Int?
  let officialLanguage: String?
  let officialNameZhHans, officialNameZhHant, tmcCid58Tabcd1Class: String?
  let tmcCid58Tabcd1LCLversion, tmcCid58Tabcd1LocationCode: Int?
  let refISTAT: Istat?
  let refCatasto, refNuts, iso31662, refNuts3: String?
  let shortName, refNuts2, building, highway: String?
  let zOrder: Int?
  let ref, route, network: String?

  enum CodingKeys: String, CodingKey {
    case name
    case osmID = "osm_id"
    case boundary
    case osmType = "osm_type"
    case wikidata, wikipedia
    case adminLevel = "admin_level"
    case nameAr = "name:ar"
    case nameAz = "name:az"
    case nameBa = "name:ba"
    case nameBe = "name:be"
    case nameBg = "name:bg"
    case nameBr = "name:br"
    case nameBs = "name:bs"
    case nameCA = "name:ca"
    case nameCS = "name:cs"
    case nameCv = "name:cv"
    case nameCy = "name:cy"
    case nameDa = "name:da"
    case nameDe = "name:de"
    case nameEl = "name:el"
    case nameEn = "name:en"
    case nameEo = "name:eo"
    case nameEs = "name:es"
    case nameEt = "name:et"
    case nameEu = "name:eu"
    case nameFa = "name:fa"
    case nameFi = "name:fi"
    case nameFr = "name:fr"
    case nameFy = "name:fy"
    case nameGl = "name:gl"
    case nameHe = "name:he"
    case nameHi = "name:hi"
    case nameHr = "name:hr"
    case nameHu = "name:hu"
    case nameHy = "name:hy"
    case nameID = "name:id"
    case nameIs = "name:is"
    case nameIt = "name:it"
    case nameJa = "name:ja"
    case nameKa = "name:ka"
    case nameKk = "name:kk"
    case nameKo = "name:ko"
    case nameKu = "name:ku"
    case nameLa = "name:la"
    case nameLt = "name:lt"
    case nameLV = "name:lv"
    case nameMk = "name:mk"
    case nameMn = "name:mn"
    case nameMr = "name:mr"
    case nameMS = "name:ms"
    case nameNl = "name:nl"
    case nameNn = "name:nn"
    case nameNo = "name:no"
    case nameOc = "name:oc"
    case nameOS = "name:os"
    case namePl = "name:pl"
    case namePt = "name:pt"
    case nameRo = "name:ro"
    case nameRu = "name:ru"
    case nameSh = "name:sh"
    case nameSk = "name:sk"
    case nameSl = "name:sl"
    case nameSq = "name:sq"
    case nameSr = "name:sr"
    case nameSv = "name:sv"
    case nameSw = "name:sw"
    case nameTh = "name:th"
    case nameTr = "name:tr"
    case nameTt = "name:tt"
    case nameUk = "name:uk"
    case nameUr = "name:ur"
    case nameVi = "name:vi"
    case nameZh = "name:zh"
    case natural
    case nameDsb = "name:dsb"
    case nameEXT = "name:ext"
    case nameHsb = "name:hsb"
    case nameLmo = "name:lmo"
    case nameNah = "name:nah"
    case nameSzl = "name:szl"
    case nameWar = "name:war"
    case altNameAz = "alt_name:az"
    case altNameBa = "alt_name:ba"
    case altNameBr = "alt_name:br"
    case altNameCA = "alt_name:ca"
    case altNameCy = "alt_name:cy"
    case altNameDa = "alt_name:da"
    case altNameEl = "alt_name:el"
    case altNameEn = "alt_name:en"
    case altNameEo = "alt_name:eo"
    case altNameEs = "alt_name:es"
    case altNameEu = "alt_name:eu"
    case altNameFr = "alt_name:fr"
    case altNameFy = "alt_name:fy"
    case altNameHi = "alt_name:hi"
    case altNameHr = "alt_name:hr"
    case altNameID = "alt_name:id"
    case altNameIs = "alt_name:is"
    case altNameIt = "alt_name:it"
    case altNameKa = "alt_name:ka"
    case altNameKo = "alt_name:ko"
    case altNameKu = "alt_name:ku"
    case altNameMn = "alt_name:mn"
    case altNameMS = "alt_name:ms"
    case altNameNl = "alt_name:nl"
    case altNameNn = "alt_name:nn"
    case altNameNo = "alt_name:no"
    case altNameOc = "alt_name:oc"
    case altNameOS = "alt_name:os"
    case altNamePt = "alt_name:pt"
    case altNameRo = "alt_name:ro"
    case altNameRu = "alt_name:ru"
    case altNameSh = "alt_name:sh"
    case altNameSl = "alt_name:sl"
    case altNameSq = "alt_name:sq"
    case altNameSr = "alt_name:sr"
    case altNameSw = "alt_name:sw"
    case altNameTh = "alt_name:th"
    case altNameTt = "alt_name:tt"
    case altNameVi = "alt_name:vi"
    case altNameZh = "alt_name:zh"
    case locNameDe = "loc_name:de"
    case altNameEXT = "alt_name:ext"
    case nameZhHans = "name:zh-Hans"
    case flag
    case nameAb = "name:ab"
    case nameAF = "name:af"
    case nameAk = "name:ak"
    case nameAm = "name:am"
    case nameAn = "name:an"
    case nameAs = "name:as"
    case nameAy = "name:ay"
    case nameBI = "name:bi"
    case nameBn = "name:bn"
    case nameBo = "name:bo"
    case nameCe = "name:ce"
    case nameCo = "name:co"
    case nameCR = "name:cr"
    case nameCu = "name:cu"
    case nameDv = "name:dv"
    case nameDz = "name:dz"
    case nameEe = "name:ee"
    case nameFf = "name:ff"
    case nameFo = "name:fo"
    case nameGa = "name:ga"
    case nameGd = "name:gd"
    case nameGn = "name:gn"
    case nameGu = "name:gu"
    case nameGv = "name:gv"
    case nameHT = "name:ht"
    case nameIa = "name:ia"
    case nameIe = "name:ie"
    case nameIo = "name:io"
    case nameJv = "name:jv"
    case nameKg = "name:kg"
    case nameKi = "name:ki"
    case nameKl = "name:kl"
    case nameKM = "name:km"
    case nameKn = "name:kn"
    case nameKv = "name:kv"
    case nameKw = "name:kw"
    case nameKy = "name:ky"
    case nameLB = "name:lb"
    case nameLg = "name:lg"
    case nameLi = "name:li"
    case nameLn = "name:ln"
    case nameLo = "name:lo"
    case nameMg = "name:mg"
    case nameMi = "name:mi"
    case nameMl = "name:ml"
    case nameMT = "name:mt"
    case nameMy = "name:my"
    case nameNa = "name:na"
    case nameNe = "name:ne"
    case nameNv = "name:nv"
    case nameOr = "name:or"
    case namePa = "name:pa"
    case namePS = "name:ps"
    case nameQu = "name:qu"
    case nameRm = "name:rm"
    case nameRw = "name:rw"
    case nameSa = "name:sa"
    case nameSc = "name:sc"
    case nameSE = "name:se"
    case nameSg = "name:sg"
    case nameSm = "name:sm"
    case nameSo = "name:so"
    case nameSs = "name:ss"
    case nameSu = "name:su"
    case nameTa = "name:ta"
    case nameTe = "name:te"
    case nameTg = "name:tg"
    case nameTk = "name:tk"
    case nameTl = "name:tl"
    case nameTw = "name:tw"
    case nameTy = "name:ty"
    case nameUg = "name:ug"
    case nameUz = "name:uz"
    case nameVe = "name:ve"
    case nameVo = "name:vo"
    case nameWa = "name:wa"
    case nameWo = "name:wo"
    case nameYi = "name:yi"
    case nameYo = "name:yo"
    case nameZu = "name:zu"
    case currency
    case intName = "int_name"
    case nameAce = "name:ace"
    case nameAls = "name:als"
    case nameAng = "name:ang"
    case nameArc = "name:arc"
    case nameArz = "name:arz"
    case nameAST = "name:ast"
    case nameBar = "name:bar"
    case nameBcl = "name:bcl"
    case nameBpy = "name:bpy"
    case nameBug = "name:bug"
    case nameBxr = "name:bxr"
    case nameCdo = "name:cdo"
    case nameCeb = "name:ceb"
    case nameChr = "name:chr"
    case nameChy = "name:chy"
    case nameCkb = "name:ckb"
    case nameCrh = "name:crh"
    case nameCsb = "name:csb"
    case nameDIN = "name:din"
    case nameDiq = "name:diq"
    case nameEml = "name:eml"
    case nameFrp = "name:frp"
    case nameFrr = "name:frr"
    case nameFur = "name:fur"
    case nameGag = "name:gag"
    case nameGan = "name:gan"
    case nameGrc = "name:grc"
    case nameHak = "name:hak"
    case nameHaw = "name:haw"
    case nameHif = "name:hif"
    case nameIlo = "name:ilo"
    case nameJbo = "name:jbo"
    case nameKaa = "name:kaa"
    case nameKab = "name:kab"
    case nameKbd = "name:kbd"
    case nameKoi = "name:koi"
    case nameKrc = "name:krc"
    case nameLad = "name:lad"
    case nameLez = "name:lez"
    case nameLij = "name:lij"
    case nameLld = "name:lld"
    case nameLtg = "name:ltg"
    case nameLzh = "name:lzh"
    case nameMDF = "name:mdf"
    case nameMhr = "name:mhr"
    case nameMin = "name:min"
    case nameMwl = "name:mwl"
    case nameMzn = "name:mzn"
    case nameNan = "name:nan"
    case nameNap = "name:nap"
    case nameNDS = "name:nds"
    case nameNew = "name:new"
    case nameNov = "name:nov"
    case nameNrm = "name:nrm"
    case nameNso = "name:nso"
    case namePag = "name:pag"
    case namePam = "name:pam"
    case namePAP = "name:pap"
    case namePcd = "name:pcd"
    case namePdc = "name:pdc"
    case namePfl = "name:pfl"
    case namePih = "name:pih"
    case namePms = "name:pms"
    case namePnb = "name:pnb"
    case namePnt = "name:pnt"
    case nameRmy = "name:rmy"
    case nameRue = "name:rue"
    case nameSah = "name:sah"
    case nameScn = "name:scn"
    case nameSco = "name:sco"
    case nameSmn = "name:smn"
    case nameSMS = "name:sms"
    case nameSrn = "name:srn"
    case nameStq = "name:stq"
    case nameTet = "name:tet"
    case nameTok = "name:tok"
    case nameTpi = "name:tpi"
    case nameTzl = "name:tzl"
    case nameUdm = "name:udm"
    case nameVec = "name:vec"
    case nameVep = "name:vep"
    case nameVls = "name:vls"
    case nameVro = "name:vro"
    case nameWuu = "name:wuu"
    case nameXal = "name:xal"
    case nameXmf = "name:xmf"
    case nameYue = "name:yue"
    case nameZea = "name:zea"
    case timezone
    case iso31661 = "ISO3166-1"
    case population
    case startDate = "start_date"
    case nameNDSNl = "name:nds-nl"
    case oldNameVi = "old_name:vi"
    case nameBatSmg = "name:bat-smg"
    case nameCbkZam = "name:cbk-zam"
    case nameMapBms = "name:map-bms"
    case nameZhHant = "name:zh-Hant"
    case nameRoaTara = "name:roa-tara"
    case officialName = "official_name"
    case nameBeTarask = "name:be-tarask"
    case populationDate = "population:date"
    case iso31661Alpha2 = "ISO3166-1:alpha2"
    case iso31661Alpha3 = "ISO3166-1:alpha3"
    case defaultLanguage = "default_language"
    case officialNameCS = "official_name:cs"
    case officialNameDe = "official_name:de"
    case officialNameEl = "official_name:el"
    case officialNameEo = "official_name:eo"
    case officialNameZh = "official_name:zh"
    case iso31661Numeric = "ISO3166-1:numeric"
    case officialLanguage = "official_language"
    case officialNameZhHans = "official_name:zh-Hans"
    case officialNameZhHant = "official_name:zh-Hant"
    case tmcCid58Tabcd1Class = "TMC:cid_58:tabcd_1:Class"
    case tmcCid58Tabcd1LCLversion = "TMC:cid_58:tabcd_1:LCLversion"
    case tmcCid58Tabcd1LocationCode = "TMC:cid_58:tabcd_1:LocationCode"
    case refISTAT = "ref:ISTAT"
    case refCatasto = "ref:catasto"
    case refNuts = "ref:nuts"
    case iso31662 = "ISO3166-2"
    case refNuts3 = "ref:nuts:3"
    case shortName = "short_name"
    case refNuts2 = "ref:nuts:2"
    case building, highway
    case zOrder = "z_order"
    case ref, route, network
  }
}

enum OsmType: String, Codable {
  case r = "r"
  case w = "w"
}

enum Istat: Codable {
  case integer(Int)
  case string(String)

  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if let x = try? container.decode(Int.self) {
      self = .integer(x)
      return
    }
    if let x = try? container.decode(String.self) {
      self = .string(x)
      return
    }
    throw DecodingError.typeMismatch(
      Istat.self,
      DecodingError.Context(
        codingPath: decoder.codingPath, debugDescription: "Wrong type for Istat"))
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    switch self {
    case .integer(let x):
      try container.encode(x)
    case .string(let x):
      try container.encode(x)
    }
  }
}

enum Sourcename: String, Codable {
  case openstreetmap = "openstreetmap"
}

enum FeatureTypeElement: String, Codable {
  case details = "details"
  case detailsWikiAndMedia = "details.wiki_and_media"
}

// MARK: - NameOther
struct NameOther: Codable {
  let officialName, shortName: String?

  enum CodingKeys: String, CodingKey {
    case officialName = "official_name"
    case shortName = "short_name"
  }
}

// MARK: - Rank
struct Rank: Codable {
  let confidence, confidenceCityLevel: Int?
  let matchType: String?

  enum CodingKeys: String, CodingKey {
    case confidence
    case confidenceCityLevel = "confidence_city_level"
    case matchType = "match_type"
  }
}

// MARK: - RefOther
struct RefOther: Codable {
  let istat: Istat?
  let catasto, nuts: String?
}

// MARK: - Timezone
struct Timezone: Codable {
  let name, offsetSTD: String?
  let offsetSTDSeconds: Int?
  let offsetDST: String?
  let offsetDSTSeconds: Int?
  let abbreviationSTD, abbreviationDST: String?

  enum CodingKeys: String, CodingKey {
    case name
    case offsetSTD = "offset_STD"
    case offsetSTDSeconds = "offset_STD_seconds"
    case offsetDST = "offset_DST"
    case offsetDSTSeconds = "offset_DST_seconds"
    case abbreviationSTD = "abbreviation_STD"
    case abbreviationDST = "abbreviation_DST"
  }
}

// MARK: - WikiAndMedia
struct WikiAndMedia: Codable {
  let wikidata, wikipedia: String?
}

enum FeatureType: String, Codable {
  case feature = "Feature"
}

// MARK: - GeoAPIfyDataProperties
struct GeoAPIfyDataProperties: Codable {
  let id: String?
}

// MARK: - Query
struct Query: Codable {
  let text: String?
  let parsed: Parsed?
}

// MARK: - Parsed
struct Parsed: Codable {
  let city, expectedType: String?

  enum CodingKeys: String, CodingKey {
    case city
    case expectedType = "expected_type"
  }
}
