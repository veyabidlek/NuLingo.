import { Router } from "express";
import authRouter from "./auth/auth-router";
import kazllm_router from "./kazllm/kazllm-router";
import categoryRouter from "./categories/category-router";
import ttsRouter from "./soyle/soyle-router";
const globalRouter = Router();

globalRouter.use(authRouter);
globalRouter.use(kazllm_router);
globalRouter.use(categoryRouter);
globalRouter.use(ttsRouter);

export default globalRouter;
