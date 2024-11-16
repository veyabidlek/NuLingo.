import "dotenv/config";
import axios from "axios";

export default class KAZLLMService {
  async generateCategory({
    text_prompt,
    file_prompt = null,
  }: {
    text_prompt: string;
    file_prompt?: any;
  }) {
    try {
      const response = await axios.post(
        `${process.env.KAZLLM_URL}/assistant/${process.env.ASSISTANT_ID}/interactions/`,
        {
          text_prompt,
          file_prompt,
        },
        {
          headers: {
            Authorization: `Api-Key ${process.env.KAZLLM_API_KEY}`,
            "Content-Type": "application/json",
            accept: "application/json",
          },
        }
      );

      console.log("Response:", response.data);
      return response.data;
    } catch (error: any) {
      console.error(
        "Error generating category:",
        error.response?.data || error.message
      );
      throw error;
    }
  }
}
