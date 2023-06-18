import Foundation

public struct EvolutionChain: Codable {
    public let chain: ChainLink
}

public struct ChainLink: Codable {
    public let species: Species
    public let evolves_to: [ChainLink]
}

public struct Species: Codable {
    public let name: String
}
