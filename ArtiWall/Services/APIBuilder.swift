//
//  APIBuilder.swift
//  ArtiWall
//
//  Created by Юрий Степанчук on 21.02.2024.
//

import Foundation

protocol AppAPIBuilder {
    func getEndpoint() -> String
    func getRequestParameters(imageDescription: String) -> [String: Any]
}

final class APIBuilder: AppAPIBuilder {
    private enum Constants {
        static let endpoint = "https://stablediffusionapi.com/api/v3/text2img"
        static let apiKey = "TouFyL4VyhWWNhqC3DnF5hAdR2fLXxgGY4Gpe4BqC8YGKE2j4NjuNrJAXetE"
        static let parameters: [String: Any] = [
            "key": apiKey,
            "prompt": "",
            "negative_prompt": "null",
            "width": "512",
            "height": "512",
            "samples": "1",
            "num_inference_steps": "20",
            "seed": "null",
            "guidance_scale": 7.5,
            "safety_checker": "yes",
            "multi_lingual": "yes",
            "panorama": "no",
            "self_attention": "no",
            "upscale": "no",
            "embeddings_model": "null",
            "webhook": "null",
            "track_id": "null"
        ]
    }

    func getEndpoint() -> String {
        return Constants.endpoint
    }

    func getRequestParameters(imageDescription: String) -> [String: Any] {
        var parameters = Constants.parameters
        parameters["prompt"] = imageDescription
        return parameters
    }
}
