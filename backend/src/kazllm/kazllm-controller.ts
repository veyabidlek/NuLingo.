// kazllm-controller.ts
import KAZLLMService from "./kazllm-service";

class KAZLLMController {
  private KAZLLMService: KAZLLMService;

  constructor(KAZLLMService: KAZLLMService) {
    this.KAZLLMService = KAZLLMService;
  }

  generate = async (req: any, res: any) => {
    try {
      const { text_prompt, file_prompt } = req.body;
      if (!text_prompt) {
        return res.status(400).json({ error: "text_prompt is required" });
      }
      const response = await this.KAZLLMService.generateCategory({
        text_prompt,
        file_prompt,
      });
      res.status(200).json(response);
    } catch (error: any) {
      console.error("Error in /api/generateCategory:", error);
      res.status(500).json({ error: error.message });
    }
  };
}

export default KAZLLMController;
