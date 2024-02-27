//
//  AIGeneratedModel.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 21.02.2024.
//
// swiftlint:disable identifier_name

import Foundation

struct AIGeneratedModel: Codable {
    let status, tip: String?
    let generationTime: Double?
    let id: Int?
    let output, proxyLinks: [String]
    let nsfwContentDetected: String?
    let meta: Meta?

    enum CodingKeys: String, CodingKey {
        case status, tip, generationTime, id, output
        case proxyLinks = "proxy_links"
        case nsfwContentDetected = "nsfw_content_detected"
        case meta
    }
}

struct Meta: Codable {
    let h, w: Int?
    let enableAttentionSlicing, filePrefix: String?
    let guidanceScale: Double?
    let instantResponse, model: String?
    let nSamples: Int?
    let negativePrompt, outdir, prompt, revision: String?
    let safetychecker: String?
    let seed, steps: Int?
    let temp, vae: String?

    enum CodingKeys: String, CodingKey {
        case h = "H"
        case w = "W"
        case enableAttentionSlicing = "enable_attention_slicing"
        case filePrefix = "file_prefix"
        case guidanceScale = "guidance_scale"
        case instantResponse = "instant_response"
        case model
        case nSamples = "n_samples"
        case negativePrompt = "negative_prompt"
        case outdir, prompt, revision, safetychecker, seed, steps, temp, vae
    }
}
// swiftlint: enable identifier_name
