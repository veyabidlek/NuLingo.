// kazllm-router.ts
import { Router } from "express";
import KAZLLMController from "./kazllm-controller";
import KAZLLMService from "./kazllm-service";

const kazllm_router = Router();

// Create instances of the service and controller
const kazllmService = new KAZLLMService();
const kazllmController = new KAZLLMController(kazllmService);

// Use the instance method
kazllm_router.post("/generate-category", kazllmController.generate);

export default kazllm_router;
