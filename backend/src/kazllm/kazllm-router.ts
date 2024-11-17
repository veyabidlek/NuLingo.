// kazllm-router.ts
import { Router } from "express";
import KAZLLMController from "./kazllm-controller";
import KAZLLMService from "./kazllm-service";
// Removed authMiddleware import as it's no longer needed

const kazllm_router = Router();

const kazllmService = new KAZLLMService();
const kazllmController = new KAZLLMController(kazllmService);

// Removed authMiddleware from the routes
kazllm_router.post("/generate-category", kazllmController.generate);
kazllm_router.get("/categories", kazllmController.getCategories);
kazllm_router.get("/categories/:categoryId", kazllmController.getCategory);

export default kazllm_router;
