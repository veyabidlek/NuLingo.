import { Router } from "express";
import axios from "axios";
const ttsRouter = Router();

ttsRouter.post("/tts", async (req, res) => {
  try {
    const {
      source_language,
      target_language,
      text,
      output_format = "audio",
      output_voice = "male",
    } = req.body;

    // Validate input
    if (!source_language || !target_language || !text) {
      return res.status(400).json({
        error:
          "source_language, target_language, and text are required fields.",
      });
    }
    const payload = {
      source_language,
      target_language,
      text,
      output_format,
      output_voice,
    };

    const url = process.env.SOYLE_URL || "";

    const response = await axios.post(url, payload, {
      headers: {
        Authorization: `Api-Key ${process.env.SOYLE_API_KEY}`,
        Accept: "application/json",
        "Content-Type": "application/json",
      },
    });

    // Return the response from the TTS API
    res.status(200).json(response.data);
  } catch (error: any) {
    // Handle errors from the API call
    if (error.response) {
      res.status(error.response.status).json({ error: error.response.data });
    } else {
      res.status(500).json({ error: "An internal server error occurred" });
    }
  }
});

export default ttsRouter;
