// kazllm-service.ts
import "dotenv/config";
import axios from "axios";
import CategoryModel from "./models/category";

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
        { text_prompt, file_prompt },
        {
          headers: {
            Authorization: `Api-Key ${process.env.KAZLLM_API_KEY}`,
            "Content-Type": "application/json",
            accept: "application/json",
          },
        }
      );

      console.log("KAZLLM API Response:", response.data);

      let rawContent = response.data.vllm_response.content;
      console.log("Raw content:", rawContent);

      // Remove comments (// ...) and sanitize the JSON string
      const sanitizedContent = rawContent.replace(/\/\/[^\n\r]*/g, "");

      // Attempt to close incomplete JSON
      let fixedContent = sanitizedContent.trim();
      const openBrackets = (fixedContent.match(/{/g) || []).length;
      const closeBrackets = (fixedContent.match(/}/g) || []).length;
      const openSquares = (fixedContent.match(/\[/g) || []).length;
      const closeSquares = (fixedContent.match(/]/g) || []).length;

      // Add missing closing brackets
      if (openBrackets > closeBrackets) {
        fixedContent += "}".repeat(openBrackets - closeBrackets);
      }
      if (openSquares > closeSquares) {
        fixedContent += "]".repeat(openSquares - closeSquares);
      }

      let parsedContent;
      try {
        parsedContent = JSON.parse(fixedContent);
      } catch (error: any) {
        console.error("Error parsing fixed JSON content:", error.message);
        throw new Error("Malformed JSON received from KAZLLM API");
      }

      console.log("Parsed Content:", parsedContent);

      const categoryData = {
        category_name: parsedContent.category_name,
        sentences: parsedContent.sentences || [],
      };

      if (!categoryData.category_name) {
        throw new Error(
          "category_name is missing in the parsed content from KAZLLM API"
        );
      }

      if (
        !Array.isArray(categoryData.sentences) ||
        !categoryData.sentences.every(
          (sentence) => Array.isArray(sentence) && sentence.length === 4
        )
      ) {
        throw new Error(
          "Invalid sentences format: Each sentence must be an array of 4 strings"
        );
      }

      // Save the data to MongoDB without userId
      const newCategory = new CategoryModel({
        category_name: categoryData.category_name,
        sentences: categoryData.sentences,
      });

      await newCategory.save();

      return {
        ...categoryData,
        _id: newCategory._id,
      };
    } catch (error: any) {
      console.error(
        "Error generating category:",
        error.response?.data || error.message
      );
      throw error;
    }
  }

  async getCategories() {
    try {
      const categories = await CategoryModel.find().sort({
        createdAt: -1,
      }); // Sort by newest first
      return categories;
    } catch (error) {
      console.error("Error fetching categories:", error);
      throw error;
    }
  }

  async getCategory(categoryId: string) {
    try {
      const category = await CategoryModel.findById(categoryId);
      return category;
    } catch (error) {
      console.error("Error fetching category:", error);
      throw error;
    }
  }
}
