/**
 *
 */
package org.training.core.service;

/**
 * @author labommid
 *
 */




import static de.hybris.platform.servicelayer.util.ServicesUtil.validateParameterNotNull;

import de.hybris.platform.core.model.product.ProductModel;
import de.hybris.platform.product.ProductService;
import de.hybris.platform.servicelayer.model.ModelService;




public class FeedbackService
{
    private ModelService modelService;



	private ProductService productService;




	protected ModelService getModelService()
	{
		return this.modelService;
	}



	public ProductService getProductService()
	{
		return productService;
	}




	public void setProductService(final ProductService productService)
	{
		this.productService = productService;
	}



	public void setModelService(final ModelService modelService)
	{
		this.modelService = modelService;
	}




	public ProductModel createFeedback(final String code, final String feedback)
	{
		validateParameterNotNull(code, "Parameter code must not be null");
		final ProductModel productModel = getProductService().getProductForCode(code);
		productModel.setProductFeedbacks(feedback);
		this.getModelService().save(productModel);
		return productModel;



	}


}
