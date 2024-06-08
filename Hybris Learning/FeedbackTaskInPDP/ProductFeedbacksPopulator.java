/**
*
*/
package org.training.facades.populators;



import de.hybris.platform.commercefacades.product.data.ProductData;
import de.hybris.platform.converters.Populator;
import de.hybris.platform.core.model.product.ProductModel;
import de.hybris.platform.servicelayer.dto.converter.ConversionException;




public class ProductFeedbacksPopulator implements Populator<ProductModel, ProductData>
{




	@Override
	public void populate(final ProductModel productModel, final ProductData productData) throws ConversionException
	{
		// final List<ProductModel> feedbacks = getProductService().getProductForCode(pro);




		productData.setProductFeedbacks(productModel.getProductFeedbacks());//populator populates according to business logic
		//covertor converts the product model into productdata
	}
}