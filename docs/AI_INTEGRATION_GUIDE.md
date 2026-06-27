# AI Integration Guide

The app currently uses `LocalAiService` for deterministic demo responses. Replace it with production adapters without changing UI code.

## Interfaces

`AiService` supports:

- Plant disease detection
- Crop recommendation
- Fertilizer recommendation
- Irrigation suggestion
- Yield prediction
- Chat assistant responses

## Production Path

1. Upload compressed crop images to Firebase Storage.
2. Create a `diagnoses` document with image metadata and pending status.
3. Trigger a Cloud Function to call the AI provider.
4. Store structured diagnosis results in Firestore.
5. Stream the document back into `DiagnosisController`.

## Expected Diagnosis Shape

```json
{
  "crop": "Wheat",
  "disease": "Wheat Rust",
  "confidence": 0.98,
  "severity": "High Severity",
  "symptoms": ["Yellow or orange powdery blisters"],
  "causes": "Warm humid conditions",
  "treatments": [{"title": "Fungicides", "description": "Apply triazole"}],
  "prevention": ["Use resistant varieties"]
}
```

## Voice Assistant

The UI already exposes a voice-ready assistant sheet. Add speech-to-text and text-to-speech as adapters behind a voice service, then reuse `AiService.answerQuestion`.
