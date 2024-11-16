import { Request, Response } from "express";
import KAZLLMService from "./kazllm-service";
import mongoose from "mongoose";

class KAZLLMController {
  private kazLLMService: KAZLLMService;

  constructor(kazLLMService: KAZLLMService) {
    this.kazLLMService = kazLLMService;
  }

  generate = async (req: Request, res: Response) => {
    try {
      if (!req.user) {
        return res.status(401).json({ error: "Unauthorized" });
      }

      const { text_prompt, file_prompt } = req.body;
      if (!text_prompt) {
        return res.status(400).json({ error: "text_prompt is required" });
      }

      const userId = new mongoose.Types.ObjectId(req.user.id);
      const response = await this.kazLLMService.generateCategory({
        text_prompt,
        file_prompt,
        userId,
      });

      return res.status(200).json(response);
    } catch (error: any) {
      console.error("Error in /api/generateCategory:", error);
      return res.status(500).json({ error: error.message });
    }
  };

  getUserCategories = async (req: Request, res: Response) => {
    try {
      if (!req.user) {
        return res.status(401).json({ error: "Unauthorized" });
      }

      const userId = new mongoose.Types.ObjectId(req.user.id);
      const categories = await this.kazLLMService.getUserCategories(userId);
      return res.status(200).json(categories);
    } catch (error: any) {
      console.error("Error fetching user categories:", error);
      return res.status(500).json({ error: error.message });
    }
  };

  getCategory = async (req: Request, res: Response) => {
    try {
      if (!req.user) {
        return res.status(401).json({ error: "Unauthorized" });
      }

      const { categoryId } = req.params;
      const userId = new mongoose.Types.ObjectId(req.user.id);
      const category = await this.kazLLMService.getCategory(categoryId, userId);

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
