import { Router } from "express";
import authRouter from "./auth/auth-router";
import kazllm_router from "./kazllm/kazllm-router";
import categoryRouter from "./categories/category-router";

const globalRouter = Router();

globalRouter.use(authRouter);
globalRouter.use(kazllm_router);
globalRouter.use(categoryRouter);

export default globalRouter;
