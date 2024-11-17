// kazllm-controller.ts
import { Request, Response } from "express";
import KAZLLMService from "./kazllm-service";

class KAZLLMController {
  private kazLLMService: KAZLLMService;

  constructor(kazLLMService: KAZLLMService) {
    this.kazLLMService = kazLLMService;
  }

  generate = async (req: Request, res: Response) => {
    try {
      const { text_prompt, file_prompt } = req.body;
      if (!text_prompt) {
        return res.status(400).json({ error: "text_prompt is required" });
      }

      const response = await this.kazLLMService.generateCategory({
        text_prompt,
        file_prompt,
      });

      return res.status(200).json(response);
    } catch (error: any) {
      console.error("Error in /api/generateCategory:", error);
      return res.status(500).json({ error: error.message });
    }
  };

  getCategories = async (req: Request, res: Response) => {
    try {
      const categories = await this.kazLLMService.getCategories();
      return res.status(200).json(categories);
    } catch (error: any) {
      console.error("Error fetching categories:", error);
      return res.status(500).json({ error: error.message });
    }
  };

  getCategory = async (req: Request, res: Response) => {
    try {
      const { categoryId } = req.params;
      const category = await this.kazLLMService.getCategory(categoryId);

      if (!category) {
        return res.status(404).json({ error: "Category not found" });
      }

      return res.status(200).json(category);
    } catch (error: any) {
      console.error("Error fetching category:", error);
      return res.status(500).json({ error: error.message });
    }
  };
}

export default KAZLLMController;
