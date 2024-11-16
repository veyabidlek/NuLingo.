// kazllm-router.ts
import { Router } from "express";
import KAZLLMController from "./kazllm-controller";
import KAZLLMService from "./kazllm-service";
import { authMiddleware } from "../middlewares/auth-middleware";

const kazllm_router = Router();

const kazllmService = new KAZLLMService();
const kazllmController = new KAZLLMController(kazllmService);

kazllm_router.post(
  "/generate-category",
  authMiddleware,
  kazllmController.generate
);
kazllm_router.get(
  "/categories",
  authMiddleware,
  kazllmController.getUserCategories
);
kazllm_router.get(
  "/categories/:categoryId",
  authMiddleware,
  kazllmController.getCategory
);

export default kazllm_router;
